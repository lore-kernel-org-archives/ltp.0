Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94909C67871
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 02:18:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C78FA3C9B66
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 04:18:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6ACD93C039E
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 04:18:38 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 650F5200968
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 04:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666664318; x=1698200318;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=l3a/1Qgjm91KW/O8cfEaSbNqcIoF3u5mFOKjlFY8Hf8=;
 b=YuaDgKTLxkkTrIQHuICyrBLzYtX0VKyoLO+Mv6+RIVzfF4KkKiS0BLGN
 iBw8SCPtvfa3tcasnVIc4yWBAmm/CCDlnc6omniNVRuXb2CN+kSVsZN1J
 vnz6JBe0wQReqnvr6PFhv2+aqGpjth0Fpmudd2PyfDQiZvfLLa3jRr6n9
 7BeSiI2qeJFY698tGB5RsFuCtttQIaKviO4NqjsimxE95MsEASi4Teq8i
 748EM6DFmaoW+3KqIGznDnjANivVLw2cmFVqyOhhGYIDL5xGT5LVglsZJ
 /IF1p2qy42Mktfs6sT6qdX8spWstWZ+rNN2ufcfa2EzvC1+LFt5HqA0ry Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="68480766"
X-IronPort-AV: E=Sophos;i="5.95,210,1661785200"; d="scan'208";a="68480766"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2022 11:18:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USQYFwwygBwcDjVVH4A97l7cSwzsi/caoR8iR2SwAMUN72E3RrRLDsyfklWCnQdjminQlsuiTqvWVqjdfyoMPIHP3kWO9IMm1fXYtteYHk48nfeOHaRyLyzs+ENFPDa2L6we8xKspoBz0gxrqflA5GksZFyTriteMQXYChna0PH9mJwqXlkVWFjkYsRKm4dUKgHvKlycgwF6bcHt9UgHKPu2bpBJ+CogVeB/jQq00kxw0KNHz+GYjI43RrvN+7Ov5ITMYwp7k3wj3tXH5f4lBddMAV5VXZSLQPyv7+VbCznN18J2wHw62p+EfMRF72ROcdRo1fWeCbBWAomKgk3Swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3a/1Qgjm91KW/O8cfEaSbNqcIoF3u5mFOKjlFY8Hf8=;
 b=YC8m8FeEd+NovGIWiN9maqdQv6JYpyLrUTN30mRYZh8aYQCDRYcV6118G1PiBaAgPKd32EE+ni2DUTmqyR1K0jjhU8xRFOMyxvsXKGHBC//mQp/itbfnDElvljNmyERO7s8fmGjSxgqxyHp8ccNZtpU8U7SzXl9mYbfXxYZpMd9wE7EKW9FbkoaMz4at2UsVKrBJcTe6h/oXhe3t/8Iv5Sly79Q2CfAhn98aBO8fIp8djX/3otb1OhCHb7SW+CqTEuxLUk1ktDXLG0sgJb01VaEfCy+RmM5VVJPvG/IlIXi5zaiCU02IeA8Tq+KPUDyBwXVVWthRqmlpL8SU77qn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB4419.jpnprd01.prod.outlook.com (2603:1096:604:62::18)
 by TY3PR01MB10317.jpnprd01.prod.outlook.com (2603:1096:400:1df::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 02:18:31 +0000
Received: from OSAPR01MB4419.jpnprd01.prod.outlook.com
 ([fe80::fac7:e474:bccf:92b5]) by OSAPR01MB4419.jpnprd01.prod.outlook.com
 ([fe80::fac7:e474:bccf:92b5%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 02:18:31 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Thread-Topic: [LTP] [PATCH] syscalls/fork02: new test for fork()
Thread-Index: AQHY5RnyMLJK4IeJokKLSlWVztBfqK4eduIA
Date: Tue, 25 Oct 2022 02:18:31 +0000
Message-ID: <97dfed7b-b69d-87b5-3742-be69405243b7@fujitsu.com>
References: <20221021065032.139738-1-zhaogongyi@huawei.com>
In-Reply-To: <20221021065032.139738-1-zhaogongyi@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4419:EE_|TY3PR01MB10317:EE_
x-ms-office365-filtering-correlation-id: 8b42d70f-1041-4100-e209-08dab62f35ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hy4yEKkFCR+D9kVKX7iCSzf5CR23xPcgdx6zkuzx+V/2tiEqAndQNbidSF7xhBPSx2oGHHGH9gHShLNYg2p7+bGjn7GHum1YByXDL2jh0Uo5SkTorIcR+9InTIT/K06PCnMEnosfxyJu6Y9Nimf88RoUHi3s01tm1V6pqmoofaCHsoaF0WkZ7t2giUtGP7S1o7ziQg7LVf1E0gmGGvJb1e6kb08nYj4YQlA15KNFW+Z54nYI4Nu8OZ1PpdULK3YbUmTlnkZGzsF5ym0hnOxdD9futw3wBAGyKUXVPLAQ2kIU4zb1fMH0cXWp+bsRJfbNWMGtKVXWECE0KQ4GcN+0bULrCQhkRk8O9HEjkMh/NCBM3TU+x1UJsIYATlU08ArQHjVkaHkSntuk8EJ4OH8t7fMwOgU44AB2N5mb37JxGqe7AzTk3K3arIC6RdGQ5yUaCl+J4ypfEdAPqdsAzA0yoS0kcK5SdHNButif/cxy7YkDK2w//Ek4jJbQNecPHy1ONCcZUmTesifDVHzubgeOfXDumURZ+kgBdtX0HneGh7ELz/FiETCIqeNdz7gbwSTbNnfLn4SuH6CLJPxUnSnxZl1ISVD/aIefrw6/Ts9Iu8QC2NtZaLuaKuubTtlbE4KELjlLqSJ1G7VunP/RSyS9HLeCKVLwXrqR+ue5YjVUjceKQ0wy65g1CwYvwUvCHnqrRO8jiPrelotSUtetOoSetzHvS9Qf9KYxoCc3ZPTX1pfHxMs1Nx9QxBa4IdjtDff4cjuvEN9JxHm3seehjxi9vCT5h0KJDhshckftpywSAbJa6yCqKiryA9PgDB7f+RfIYjGZWf3vO5rlYg9hl/3u/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB4419.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(1590799012)(2616005)(31686004)(1580799009)(66946007)(66476007)(66446008)(66556008)(64756008)(5660300002)(6506007)(186003)(478600001)(83380400001)(76116006)(85182001)(4326008)(91956017)(36756003)(6486002)(8676002)(71200400001)(82960400001)(6916009)(38100700002)(86362001)(8936002)(41300700001)(31696002)(2906002)(122000001)(6512007)(38070700005)(316002)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzM5Nmt4VUFDYmVYWVFGaTRQWk04em1mZzVYVEN6aEtibkUvWk1VY2ZaSnFu?=
 =?utf-8?B?UjVYMGpiWVh0eG9tTDdETW01ekVTZjZyNUVJbndPRXlWM0lvYUtPMGluV3R3?=
 =?utf-8?B?MEo3cTd4UENHMXVSamJ5NmV3WFF3bDY5OFdmbFdaZGhucCtuU0VWL2IzQ1hY?=
 =?utf-8?B?eU41dHVQMGtXMkJNZy9hdHhwcE1URXFSUUtCOUpJYWFsTkNXZ1NtMG4wOVFL?=
 =?utf-8?B?STZwc1FUdlc2VXI5ZlVJdnlnWVBnZFFUSnBXelpmREFQL09yMDNCUFdNOEx3?=
 =?utf-8?B?NVBJTFlIK2N5YnlPZ0ZtZFZuMTlra0RmZWl4a2VxK0RzcTJuWFhUSGNjdjdk?=
 =?utf-8?B?SzFsVjh0Tmd6ZjRUSkw5cTBndnM1cW5oTnlmVEpYWFNjNTRLMGYwVE1iRzQy?=
 =?utf-8?B?ZVpQWktOUGRQb3pJamgxbC82UmNLTnlVMk1OR25QSS9HSTNxTDEzTHcrL0pi?=
 =?utf-8?B?ZHdVV2lUVEJHTmNQb1VmK0MwQzlVb2pacWZtQndHbWNRSEVUOGhmSHdMRFdC?=
 =?utf-8?B?UitaUlV6OWdhd0NBUWo5SWJNSWdlQ0E0c0hGZDh1dUh1elF6YXZWTUVScysv?=
 =?utf-8?B?NXNUSG5PT29Ha094SVhlQVU4Vko2cXgyTnhHZXBTM2kvcXE0WGZPUjgzdDVm?=
 =?utf-8?B?eCtmM3lJQm1jVzFyazRYSllsaWNyeGJpY2VFMzZYKzJNcGhSQllwRVRoTDFX?=
 =?utf-8?B?S2ZuYXlmbzloRFNWSVFLd1NFZ1l3Q2pEczNIR3BhcDVUVldxQ1hacnc1c0FM?=
 =?utf-8?B?OVk2OG1INlhKRERCMncwK0dVVnp0cEFOUHhOWG9NTkVMc0xoMHF5UTdUOVQx?=
 =?utf-8?B?SWlvbTdDK256UC9kaGMyYlRFUkJKZStwRVFYeXhWMm9TOW1ncGtvbkk5dHpj?=
 =?utf-8?B?ckRtTFAxaGZhVEhXOEZ5cmQzMWczN3FQbHJJRi9MajhyK1BVcjUvNFIzdzcy?=
 =?utf-8?B?Z2FJS3JKNGp1THdEQjNJRkIrd3Rhc1lzYXRISktyVWdkbDQ1eTZIRmR1Y045?=
 =?utf-8?B?OEhsQWRzK21LSjl6K0dDYzdrdFhEelpBWXU1dUt5b2NtS3MxaUtUZ2twQVY5?=
 =?utf-8?B?Rkg1N1kvc3I1Vkd0K0ZzWXQ0MS9XL3RqYWdvOFNSSHZmSlhrY3RvVFMwTjhY?=
 =?utf-8?B?OU5wN3o5eTE2QjlFVXZZbnEyZzBzd2kxellORUNKd0xkcWErcGRuT0p2c0lP?=
 =?utf-8?B?WVYvak0rbVh3ZkZkYnBBTW9abkJvUTdUK3J2dEN0TFJxeVVsY0Q4RnU3ZS83?=
 =?utf-8?B?c2xNZ1d6VHBaUDVLSlhxd01jQUQ1UU5nZ1puaGxZeUJ0eFY5R2dNVHNDWUpN?=
 =?utf-8?B?c3QzM3E2RTVBKzRJMGdiNEFaSnN0YnVpTkRYUG9CZUFkMUE0STh4TFNqZHd1?=
 =?utf-8?B?NVd5clJzV09Rc2M0S0NRaXpOSnEwTkp2NHJybmFvdjlhVDNabUhrTHJHRmUw?=
 =?utf-8?B?Nlc0UUFUYnVWL0lQS1RJekhtZVN3QUpZTzBxZ0w5Rmd1Q0ZsbC9XbFRTNU5V?=
 =?utf-8?B?QnBYZzVSK1Q2RFpiTG1Rcml4dUxWNDBZUDNlVXlONFVZZUsxWlErYXpnSEZ5?=
 =?utf-8?B?RlZaT2JvQzR2bU1nVERYekRuRUdHVXl0MHRuaGd1R3ZSUVVYVWE5aHFveWZw?=
 =?utf-8?B?dDYvaGpVNXBjV3pva1Q1RjJRckFrZTNpK28wRWlJb3Nyb2t6ZzgxSWtiVkxY?=
 =?utf-8?B?VWU3RWNqZ05kSmVSU21jU0FId2tTVDRVOWZOaGowSXZSdmhwWlBYMmRycis0?=
 =?utf-8?B?N1QrOWk3YzM4UGZxaHliZXUvd0lMSFVyK0hicUJWWDQ3VzlPbjlaSzFnNk1i?=
 =?utf-8?B?QkN3S1pvUnRyNU9Rbk1sZTUwYzVicHNIbmhURjNtMDRrYTdjVFpkNk0rdGEv?=
 =?utf-8?B?TzFFdlRrelNmWFV3MzcyTEdrbWg0cHhXbUc4Nm11YjRtTmJPbkozK0VvbVV2?=
 =?utf-8?B?S3I1WUlhMkVzSWRSd3Jjbk9KVWhmdHRwMm0wMHpPK3M3YzRpOFZreVZ0OTVn?=
 =?utf-8?B?TzFGeUkyUkVFVUFEcHZNRCsxTHJiMW0rdFN4bGdWeEwwZjFCZXZzY2c5TEJj?=
 =?utf-8?B?MmdhWEVMNzVBMFZlbWFnZW1wRUlyY0ROcHJRQnYwSkZESFRqRDJJb0s5K05s?=
 =?utf-8?B?UDBaMGYvQkZmOEtsWnpyckxaK1pZOTVVK0FQZlJibE91YnUxb01HTEJnYUlC?=
 =?utf-8?B?aHc9PQ==?=
Content-ID: <733A57D837B72F4B852FD148A9B0584A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4419.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b42d70f-1041-4100-e209-08dab62f35ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 02:18:31.1714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5QZmsi3klg4+G1RH+XiZnwjp6ze0q0r86yz5Ezur2cjDKtzxxoxJ6Uw6le5pUtyWPtSxjDa38FJo47J3AQ+LhhtvHTsZZUqp/fSXWIbFjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10317
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork02: new test for fork()
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao

> Verify that current workdir correctly inherited by child.

Why test this?  Does fork() man-pages menthion this?

Best Regards
Yang Xu

> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   runtest/syscalls                          |  1 +
>   testcases/kernel/syscalls/fork/.gitignore |  1 +
>   testcases/kernel/syscalls/fork/fork02.c   | 51 +++++++++++++++++++++++
>   3 files changed, 53 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/fork/fork02.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7a425439a..39b7f21f6 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -364,6 +364,7 @@ flock06 flock06
>   fmtmsg01 fmtmsg01
> 
>   fork01 fork01
> +fork02 fork02
>   fork03 fork03
>   fork04 fork04
>   fork05 fork05
> diff --git a/testcases/kernel/syscalls/fork/.gitignore b/testcases/kernel/syscalls/fork/.gitignore
> index b817e9c05..8a08c586b 100644
> --- a/testcases/kernel/syscalls/fork/.gitignore
> +++ b/testcases/kernel/syscalls/fork/.gitignore
> @@ -1,4 +1,5 @@
>   /fork01
> +/fork02
>   /fork03
>   /fork04
>   /fork05
> diff --git a/testcases/kernel/syscalls/fork/fork02.c b/testcases/kernel/syscalls/fork/fork02.c
> new file mode 100644
> index 000000000..54ad50712
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fork/fork02.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright(c) 2022 Huawei Technologies Co., Ltd
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that current workdir correctly inherited by child.
> + */
> +
> +#include "tst_test.h"
> +
> +#define NEW_DIR "new_dir"
> +
> +static char parent_cwd[PATH_MAX];
> +static char child_cwd[PATH_MAX];
> +
> +static void run(void)
> +{
> +	pid_t pid = SAFE_FORK();
> +
> +	if (!pid) {
> +		SAFE_GETCWD(child_cwd, sizeof(child_cwd));
> +		if (strcmp(child_cwd, parent_cwd)) {
> +			tst_res(TFAIL, "checking of cwd failed: "
> +					"child_cwd %s parent_cwd %s ",
> +					child_cwd, parent_cwd);
> +		} else
> +			tst_res(TPASS, "Checking of cwd passed");
> +		return;
> +	}
> +
> +	SAFE_WAITPID(pid, NULL, 0);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR(NEW_DIR, 00770);
> +	SAFE_CHDIR(NEW_DIR);
> +	SAFE_GETCWD(parent_cwd, sizeof(parent_cwd));
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};
> +
> --
> 2.17.1
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
