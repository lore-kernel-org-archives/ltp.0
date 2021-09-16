Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A970C433F5
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 01:55:25 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD9F611C8
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 01:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FD9F611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 398153C89B5
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 03:55:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 896373C1D7D
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 03:55:08 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0CAD91401140
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 03:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631757307; x=1663293307;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rZ58v8DXfwqj7hXmz/pmhOrtnBMNaXh74ehqwTl+oe4=;
 b=S4+aeEUAH6p0xj27tl8UZQuD2glIcCE4ragoeXjXFB/0KcwfMK4cQzeu
 nexVeYGbFFhW78wTtbdxNh3KkWyFPgnwpmWNhl4hQO2jqvL6tdNflC3UU
 eM7xcp1A78iHPsSqF8d+jW/UQeiX5Nm+Txb0mWNOE+SqffAKO9alJkE/t
 SBJsgtG5rT3DBA9QJqFsst/6lFnuMBs9+Y/YRZ/4+J5+A/+sILHbyF1k3
 c4LB0mTrYqyKGoZQHXbfhg7VVPxVRGLHUzShk4T13R7zMtOKD+nmTpJ5d
 abskerSNnKhr4exqyxn/bzmvwVs+WeGfL4ReOSNqM+EV74eJe2MNT6GBE Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="39188044"
X-IronPort-AV: E=Sophos;i="5.85,297,1624287600"; d="scan'208";a="39188044"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 10:55:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYuQHtSCeX+5ZjdfxCgChYcr2c3CAwcQMydRfc+PNy++A2QvcTzWi1iJV8McIBJ1x3LDDZ4CHl92l1OVkATs/kRZ699bjgyftxS2Gi9VN5LjGG6h8VqUKZqGB3zQ6BzYrzKsyC8MB0KyqHySjeqIbcmgQrzqF/KmL07fLhq+5/TOzdDU+GDGazWX3b+SvuCdlJs9hwL1ori7c84uZXoIdqCIJHMOFxnO5vRP/RB+4bqIn5KrQ9hrqvsYKcJYvqn2Kmn+boYWK4UC9pVwPNDhba9EVcVaklOMVprEJeDNcoUSNHYFSIi2exfWylq7oyO2teXdOI3E+He8hbiZKzIRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=rZ58v8DXfwqj7hXmz/pmhOrtnBMNaXh74ehqwTl+oe4=;
 b=WPH5H9hzeKS0PMvEfVy9r/Eg2IB+/LLMgGTu+NIpmnTj0nO02diqaOW/nAF1bqDoiZDQQkCMuyOV/HaF2DQxZS9B8gCfC3rW33cJa5YPVd73GvgsF7iK7h9GfxIMvCnQYN2Ch3zrs4EvJ6goR3JIvQlEFN/Zt8KiA4bsKj6Jy1FeV+Nv8T9yHWL+qBi5GY38Gf5u6DPY8vs7lXRUacn0KglWTejp8jalqF87VRXkDrAbAUUCmmH+mUEf/KtoLmJEI3B4mgqt7Zj8JreIWdI7ploNwi6cQlQCiPzw7v8AuUfO/p2FgsgVXV7TsS5ZBA7EE4ajGrL1RtnhxTKnwAzx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ58v8DXfwqj7hXmz/pmhOrtnBMNaXh74ehqwTl+oe4=;
 b=X4QlLGsO27IZS9nsfFuLkZrdzr8+vL8DYJrvQJzAvO1PL8AL6/0evgPcnB2xV0vHz3mBYp2j1v0idiwXg2Gx2g6zGYDqRiJfqNLATMZJdq2gMSUE8co5CAvIKrZ9RQhnn3AnE44ZPgK78fsxtjaGBet+rcGKXAMdHe/xHOQ3qt0=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB5194.jpnprd01.prod.outlook.com (2603:1096:404:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 01:55:01 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%7]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 01:55:01 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH] syscalls/shmctl05: Remove shm segment only when created
Thread-Index: AQHXqkXjWvSJP/fGkkqso/2qCdw1Cqul50SA
Date: Thu, 16 Sep 2021 01:55:01 +0000
Message-ID: <6142A409.1090605@fujitsu.com>
References: <20210915152533.20902-1-chrubis@suse.cz>
In-Reply-To: <20210915152533.20902-1-chrubis@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 348ca6cf-d0a9-4a72-c675-08d978b4fef3
x-ms-traffictypediagnostic: TY2PR01MB5194:
x-microsoft-antispam-prvs: <TY2PR01MB5194D3A371675288E2C2F165FDDC9@TY2PR01MB5194.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X08DBOWeTK853wkn/nvKHGQ2OHS/9m0mrDHOY4A0NKtL19vADAag+qDoDDTCgJS/w1o13TGPMPHX5ksMzz1r7DxPA3ryH228pzkbKMi1hGsEAhI7sKF31rOTNXpub4hS1lyBDaGAtW+4ixu8mMB3ymkSK88heaA2MXMKpM/6/ko5YwIYRiitTPvWH1JzFc9+lXau7RXe30p9gXgrc0ba3VS1mHUAQLbI4hiWAclhRBKpS+7P4QineSweYZPhMO/Re84Dy5r7jdEKJTAI0dirppovoQPZcegxmjCX5yCpRREK06h8fRXzsAE2wDIvoZVrRjgfFvBJaC45y2yzdBoVB+l7hJEmCufp+nd4uwTdVcbA1T+JLDk4i/Qq14weysR5wgktXx9R12WJElBBpUXSXhtqshz2FoGzyuMq4md5Z/sJCMgAUfp2ql4pANpe5Y8E0eodawa4YQ8iryDx3BqSOaxPTp8Npwq93Di9dBgacFkOS6S8pRF2aFDm4ULyvazxivUjCZHPddbDwPTYDFT9VanGiWVB/QOX66NjZm+MTCFPpf9oxwnbU3IT/mU779sKmaki54Bz0X6b8lFkx4XBMMj/Nxjjnq7lOgjLIUWSQZXYLkQpQXtYYbFWWhCzPp4Ui7/N6DSu+gPHvrICwJMk2e+utpvsXwfckTbrOIEPylYeJcCnvMF3qzPFePE/xj5yKvJc1XXsYX0XMxr5Mnq+PQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(8676002)(26005)(478600001)(38100700002)(122000001)(83380400001)(76116006)(6486002)(2616005)(91956017)(186003)(66556008)(4326008)(66946007)(66446008)(64756008)(316002)(6506007)(66476007)(8936002)(5660300002)(2906002)(33656002)(38070700005)(6916009)(86362001)(36756003)(85182001)(87266011)(71200400001)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WmpDN2t0bFZCWElEZE1weU5tVUdyelBBZ3hOSWZtanRReWQvZFRsR2pFYVc2?=
 =?gb2312?B?ZDcwbDM3MTBjMWFRVXdNa2VWd1BQdjQvb2pDSTJKa1BqR0FuaXg5cGZNc1dZ?=
 =?gb2312?B?OXEycjd5MUsrQStEVnhFTG41OHRaREt4YjJnd1JCcGpuN21oZkt0d1F3a0ZV?=
 =?gb2312?B?WWlXSFAvd2NScFVibzhqTmVwc1ZodWN4Z0ZGZVNhRG41ejJ6ZEEya1liaEY3?=
 =?gb2312?B?ZFNZcnlDNXhkek5scTNZTkZSRVgweHFyNnBPei9JYU9Mb0c3RlVSc1pONHkr?=
 =?gb2312?B?eTBhbjg1cHFKb1Z6b3VNOFpud28wczZhUG5xeXFSNEMzY1BHYkdac1FyKzhC?=
 =?gb2312?B?SDd2NHNiSlkwRVNmWmdJZW9CTTlrcnp4ZC96MjVSMWlzOHBvZkpQdHJ2b2NM?=
 =?gb2312?B?WnVrV2NwYWgwTWE1UjkwV0xEYU0rWEVVbFJEMDFIUjRNdHAzWHBORisxTjVz?=
 =?gb2312?B?NHBsNVkzaWxLQjFsZldNWTRjVkpLcEpxWmRLV3VLN2tvRitrbkRiVm52Sk9U?=
 =?gb2312?B?a1hOdnFEV00wd3d5UjR4UGQ2RTkydXNka3FndjNQWU14VG45QmYwV1hYUmlx?=
 =?gb2312?B?Ri9PQ1I3dXNseVdBU2s3dXZmUS91cEphS3k2MXJpSVA2U0grSlNnYXF4UVpj?=
 =?gb2312?B?YmR1VE9URkNYTDRNdmlXd0w0NUpkbjROSzhqOWE2ZjFwTUdINDhLZmRSd2xT?=
 =?gb2312?B?OTg2WUtLQitMUDdJU0t0cVNLaFk3UnlVYUJldzJ3M0dqN1FUaDk3SE4wZWRa?=
 =?gb2312?B?WEhQYjlpaGFIdzhxaGhOK1V6Z2NWOStBZVl2enNrVzFSVVdkdmN1U09oaUFL?=
 =?gb2312?B?K29aVDNZNEFwa09XeGNGTnRzekVrZGVZZVBqcjdOODd4ejQvYTFqOVZ2ZWVz?=
 =?gb2312?B?R2dlcHNQallNL1RlZ29hWitCamEzWkQ3Q2hHQWZpVkZYc1FSOUJwSkVqaDU3?=
 =?gb2312?B?eithdzUzRzFpWEdFdVorZUNLS0R6Z0pNeC9DOFRUdHNzM1JSWnFjeUxLUjJR?=
 =?gb2312?B?aC8zbXJFQS9CMnN3QkFkc0RFV0ptanRhYmg1WTl3NHBXKzdzZjlSVTdlb25i?=
 =?gb2312?B?UHpnK0hLRDF3NFg2QTYzWWlVN1hKZ0JsSzkrMWRUZFJycDFWaFZ2VlNRSGZI?=
 =?gb2312?B?VDlKbjNwaXN3RmRic3JoTmtpc2hEemw0NW1wdXlOdnY0bDQ4ZnB2VXpDM3B2?=
 =?gb2312?B?UEVWUUpNZFNSQnRvTDFkZWg0QklKOU9aSWI0NmZ2UlB4V3JoL2cwU0ExdkJm?=
 =?gb2312?B?enVuWnhlWVNYUnlkOS9sMlNJcHE0V2p3eTZyLzZSdHlSN1kxZ2pPb0NVUWJF?=
 =?gb2312?B?ZkpEL2xUMnIwRmZybThPK2wvWDlkaWZXMmhDcUFuYzJTVkw4L2ZqZWxZb3R6?=
 =?gb2312?B?enVrdWFXTVVFemI3a0VlQ2MrVVM5Z28wejUrWndaNGlpV3Q2SlpSVzdMQXho?=
 =?gb2312?B?SUZGU0ZLRHF5Y1pzTlFqRDF3MXlnU2sxT09CZkhncVZQcUxCYmxYNThWWFpM?=
 =?gb2312?B?KzMvMnpQRExqM1pCS21lUUx4dFQ4Z1luSytwYzlPNjFOcDlvWEh3anlBdGUz?=
 =?gb2312?B?TVF5eDhlYUZjR2o2c2RKdXZaMzg2bHpzL2VXc3hCQXRrYjdDSUs2dGMwQnJl?=
 =?gb2312?B?VHZYOUdxdnA2cXNGNklWd1JnVFhtNG9JTkdmS1ZYYUtCWkRpSVlKWnVsVytH?=
 =?gb2312?B?b2M0RERJZFNDZ2RCenExeTdURmloSjdVaFVxVDltTXFyWUdUTnlkeEJHaDBr?=
 =?gb2312?B?bU04bmZYS3UwYkc1amlXbFFiN0pYUDZialc2QUJlSUVuOExiNGloME9DdHRu?=
 =?gb2312?B?eCtrSStUMmtYUHpZdU8ydz09?=
x-ms-exchange-transport-forked: True
Content-ID: <F42E7B3F29A0094ABB3658D2D7AC8C24@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348ca6cf-d0a9-4a72-c675-08d978b4fef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 01:55:01.5326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nf7+2OFizfqAOSdmXVIT3oJc2j80T0knIZiFDipXDvHq2+/Rb16XCu8Vq9g6ruGOjyjK6ZGhd8iP1NKCEEsXrzs1sHmDJpwstfAOw/McvGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5194
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/shmctl05: Remove shm segment only when
 created
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
Message-ID: <20210916015501.xn-cZ_D-2QM_737oJ5Q8zmBgjVKmXYvbTqxELKGQ17U@z>

Hi Cyril
Thanks for this fix, merged.

Best Regards
Yang Xu
> We cannot remove the shm segment unconditionally. On kernels without
> SysV IPC support compiled in the test fails with following:
> 
> shmctl05.c:50: TCONF: syscall(396) __NR_shmctl not supported
> shmctl05.c:96: TWARN: shmget(61455, 4096, 0) failed: ENOENT (2)
> shmctl05.c:97: TWARN: shmctl(-1, 0, (nil)) failed: EINVAL (22)
> 
> Fixes: 48d382e8daf2 (syscalls/shmctl05.c: Fix leak of shared memory segment)
> Signed-off-by: Cyril Hrubis<chrubis@suse.cz>
> CC: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/ipc/shmctl/shmctl05.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
> index ea7eef6f1..8569322dc 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
> @@ -92,8 +92,16 @@ static void do_test(void)
>   static void cleanup(void)
>   {
>   	int id;
> +
>   	tst_fzsync_pair_cleanup(&fzsync_pair);
> -	id = SAFE_SHMGET(0xF00F, 4096, 0);
> +
> +	id = shmget(0xF00F, 4096, 0);
> +	if (id == -1) {
> +		if (errno != ENOENT)
> +			tst_res(TWARN | TERRNO, "shmget()");
> +		return;
> +	}
> +
>   	SAFE_SHMCTL(id, IPC_RMID, NULL);
>   }
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
