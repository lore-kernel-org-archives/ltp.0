Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812EEC433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 09:11:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 992993CA315
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 10:11:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 006C03CA1D5
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 10:11:35 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BF0F140110E
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 10:11:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646298694; x=1677834694;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=YufitGKit0GTqReLtpFrxJxeNmAP+N2gARt4wZB+ylE=;
 b=MUJ3uXFc+v08XjEq7HVNygBJj89IPyQkVAtSejzab84m+zML78IFILHM
 zS/9+RqLaHWzfWuktvJ32voifE8UW0n7WHN20a0qzHvoVPx4v9ApXBDLy
 8rEG+ae0GPtiLKxpc3KlNQaGk0eXrmfjsX/l6leRZ8IwkPh+L7++An+rA
 0i9V2H8TKMp0L1P29FfqpxRiO+arz/wWsg2XiNfdKuA14VVl0BkcRA7QZ
 IjiqedRyl//y/8F6B2rc/EI25le9yrntB08HOVrJbMGrvZbjcaG1z20X7
 z6U13jOytOG7jFIcRB5hnlaNKOMkjTtTPrnKn/Uc24rb5dg1yEzuUX3iJ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="50868304"
X-IronPort-AV: E=Sophos;i="5.90,151,1643641200"; d="scan'208";a="50868304"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2022 18:11:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ate19m5BVBQc14UPoWUlj03jRv8z4D6MhZ20hsMxcK11o7srthUKJf12KCPIe9WoRs92MN4wjLLy84pl4Bsfiww8la+uxPAOD3VI6CHJuGi7nvekfdbUQJ578ZrZzNieLgZc4QlJnzFEA+D7O5jRn9e9hzvNdq2FKyCdtsShREgN1keFPsntDJSzSiTGHWkJMPzf9jVPfWe0ZmQxIDoYzd0KaYCF95+oviQkAhSUgPcvXDZzG1VVAkXKUeWwD1aXlUIM0HHNo1t5Kof3F6pTcg1MdmOAfaKtJBScKXjAKD8BU6NJMMk/ITxfQv5anKrZwA7KpGmxyBygyJNd5Dl/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YufitGKit0GTqReLtpFrxJxeNmAP+N2gARt4wZB+ylE=;
 b=KZBYcUkuOa1/1gXF9MV69im1E6/TJlkl3yGlQLcb4LRlWgAsgrB/2o8BFSB4fN2z1XbsLeHB3a4jq2AHDO+a8hr/WkDr1O2DDsMK0Fs/5aEABxRFGfTYBuc53R6A1cs+iQx3OxL9tdeukKptK1TPLypmQHac9TRVmFXmVFB21IlA1ki0MVOF0FZFDboYd16goxRjjn/RchDo1hv3SMEHMyYB4ilkkvjzufQlUS+FJczLezS1bvpT6DVTxjU25xMLJ97NVRKe2vlseNVoEoAt1KB3RvI0ORemYCCIgla67DAPeXIGJiNgfmn5U4BIhNRa5LT6ne4/rJfI91duBQ0apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YufitGKit0GTqReLtpFrxJxeNmAP+N2gARt4wZB+ylE=;
 b=WoS5FR58YmlgM8NypQKG5fbDNYORrdn/61QZjZGMGBVb7ykKpfUe4r29NT5h0gYRRTx1ygXw5R8R5egpL7JmE1V28iSaKUu45a7GMh38pDksrdr2PHweVRy1P9AD9RmEbIBdd4UF4zk5PA9lo/1K2T5p44Oqmnm7Gi5kceWxLYc=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB4192.jpnprd01.prod.outlook.com (2603:1096:404:bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:11:29 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::38aa:3980:b578:98b2]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::38aa:3980:b578:98b2%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 09:11:29 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] syscalls/setsockopt09: Add another linux git
Thread-Index: AQHYLtx4CjNbvmY4GEm3jKnRYeFwH6ytX9yA
Date: Thu, 3 Mar 2022 09:11:29 +0000
Message-ID: <62208677.4010600@fujitsu.com>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88a77bc3-25ab-4de7-51aa-08d9fcf5cd63
x-ms-traffictypediagnostic: TYAPR01MB4192:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4192C7F36B58D62806166F7AFD049@TYAPR01MB4192.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sSAmV9dxjVC9DlwSicuCyt7DFX6jrR42SNGCk/zyxXLitMSUYEw6ctxTQsFg3Zfwv+s/B3qUGe6P62lrzpkfMh266A9JRgqfrwZukgEgTYa+KPeucpfMowMsGqe//A/8RYzzizujZutPYgOdHZPgcoL68qY5DuXnzeTSH9GhL7oKtU+P4o/uXStkLnPm3bDPqLTqW8tLwbxuOWQohr1XR6vDmmhg0R7azvAQ8GjS2YMF2G17qEeTHJVgj8YnlmBgC5u1hRK8oOm+MXZ8BXxM2K9SC0uBwuV3raENYrFfR4O8s9KpWpi/IYlQ9T7rUQDcXE9BX5XsSpuMcIAEls2BrxvrDySWioxU03jaJ9nsSlR17s7D7BVspSOulAmiA3un+c6IeJqrkqfux2WOxGapRq9qnCrYpu0pn5dcO5SpaThq9ga5a58YqLVHo7teYT+slcin9YEDhPFGih0Di21vheaV5fdNIQSg0nSOtpj+nFB6xMFPwz7ZRXUG7qDN6mx1jQHmMEMmJCtkFhbFO4+OXNp24BGY8Bl6K9sUArd4B/5f+msc5fE8ypD/GsVSIdy1fv9WwNefXSPQ/pWclm75v+O/KS89fdjAotTar00uE+aNGZH2Nc39ldxm9vj7o62vKji59p2ieWtLHnoOUCrSe4FFSxzsGxcRpKcPijuGF+TK7lfioepKu14fjxRqDQ0Gh32HDcYLgd2sCCMklwbUJmZ/s86KY0MUdHzT2Hld8ec=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(66556008)(38070700005)(508600001)(8676002)(6506007)(64756008)(66946007)(66446008)(76116006)(38100700002)(66476007)(91956017)(2616005)(122000001)(316002)(6916009)(85182001)(82960400001)(6486002)(86362001)(36756003)(26005)(6512007)(87266011)(2906002)(186003)(5660300002)(8936002)(83380400001)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MEk0YU9JMDdBMVdqSHQ5LzU5WWcvQlR5K2tzckFHL0RnUXNJSG4rOWlwK0NY?=
 =?gb2312?B?amJYM1hXRkJPVkFIVy9RR2w5aDZBRSsxL0Q4SzdDQnI3bU5CdzlyejFEZ2tZ?=
 =?gb2312?B?MnpyWGtRVFpaQis0UTRiNVZqNUdObXFnY1RhYThGNGI1dmRFSERaM1BCeEZo?=
 =?gb2312?B?WG80a3JFN29TdjZyMmlhbStqcmxSbEpqNUxpUkF2NmN1NytLY1JIRDBrZ3dJ?=
 =?gb2312?B?NFgyc1Q0d1RScStyaFY3RlNQTUdRT1E1K05HMDU3c0QraEY4bitabjQ3WXdJ?=
 =?gb2312?B?dytmWVNVYTBtRUR3VVVRQmRKVUlQVVhVcHZFK2pjbHQ0dnNrMTRRY3N6amRi?=
 =?gb2312?B?UjNmN29TMWRGK2I5NG5VZ0lQT1BOWEdDcXhTNTJJM0NyT2xtVXVoN0pTdjZY?=
 =?gb2312?B?d292Y3BQNjkrWUVpNzlqa2RkWUJSVG51L2V1VFJBaXpLaHdpaGN6QWhxQXBS?=
 =?gb2312?B?WmdjYklrQjdtaDIvVERqR1hxdG9qUGFCMDdWcHJyaGhvVnk5dUtvUGR3WmhP?=
 =?gb2312?B?b1Y4UC9uc3M5UWpRcC80VHE5elJ4S2NLbHVlcVBndENvNVNTMHZpVGVjN0hO?=
 =?gb2312?B?dTNHUERadjhhYnVZSW5qOCswdEk3OHdtWTM5TXNiTGlNRUkzRCsyNWc2UkxD?=
 =?gb2312?B?czFiLzlWS1NwRVNEZ2lhZXZLV25MdEE5OWZEQTV5WUNVa1JQMHFuZ0VqYURT?=
 =?gb2312?B?YnNRSzZPeVVjRENidEpBZWpFbHBHM2dSQXNvUlFTMktDNHZMRlBvTmtORWFI?=
 =?gb2312?B?V0ZqMWRubGVmUlloZU5CelFvVDVrV1lnanJnYkJjVU9uOEdBT25PV2pzS3Ay?=
 =?gb2312?B?Ynk5QnAwNi8yQmxNVjBCalJ4NVMxN21VcDBpZVlBRG9HeUV1dWJ5cXhCMTly?=
 =?gb2312?B?NjNMUkh5Ry9tbzlHWmFUd1BnUlRFK0sxQ3NwdDlQQXk3NndUQWczTmpJbm5V?=
 =?gb2312?B?S3NwNFRPMVdadHZKSEdUYW5vNnJ2WElXSWltY2ZYVmpza21MK3k5eTZodWdh?=
 =?gb2312?B?MlVVS0hPRGRkcC9UN0lnZ0JrZUVRc04zVlgwcDV2Uml0NVAwWjlwa0lEcXJx?=
 =?gb2312?B?QWZyTGYrd3cvT1FwajdWaFAxZXhaRkJrSlorNm45cHlFZjVSb2tOWWVNWkpO?=
 =?gb2312?B?UEZ4bjQvQThBMWVDN3lpRytpWlE1MXlkVkFuZ2VGa2xtTm83SHdwckI0d0FW?=
 =?gb2312?B?eFdnRlJzMkxUYlBxZ0dpYUNGWk56S1JIbkJ0RENWRDYvTVEyTFlWLzQxRHRh?=
 =?gb2312?B?NHo2a3J3R3Y3VGlpRC9UMjhlZks3RDF4Y2JqUStjZ1dJenlTVzBIZHdSWTB4?=
 =?gb2312?B?dVZjRmpMc2lxcFpBT09ROEJYY2lEaFcwTmxNaE5uYVBXSy9Md2hQS2J4Nnpm?=
 =?gb2312?B?T2ZjZ0NKMmFBV2tyS3JqVEh2amFFR2IvM2c4YnlDUDZTcVF4a2d3T3YydzFx?=
 =?gb2312?B?ck10d0JkRWNQckZpZEtROG5JOE13cHNzMk1zY21Lc1NxeDNvc0FranlyRVN4?=
 =?gb2312?B?SDJYT0o1MVRBMEptdHZqdzhaYTIvWFViUTk0c2RqTy9rYUwxamN0ZkxpTEFL?=
 =?gb2312?B?Sk4rUHI3OGpLYVRqRHc4T0lkc21Ba25GNUk3TzNTaVdSeXpNOG1tSFk4dmdR?=
 =?gb2312?B?ZndBWGpRK1pVYkhtYzdjSE00L0FYVzFCQlNsOXkxQk0ybWdJTlN2eU5rTkRr?=
 =?gb2312?B?SEgxS0RJYlBRZkQwUEV6aytubmNVSG90S005a3RQQkVDVnNkQWpSc2hPZkhN?=
 =?gb2312?B?Q29NYkUrOGZET1MvbDhIZG4vYTJrRmFVMHMxWlJ1aWZqblJnMjRFV3RUNHpw?=
 =?gb2312?B?Qk9hNzFOenRhVGJJaG4zRC9pYndoa1hVbEZFTnFBV09oZmRSVFBvOTBHVHpj?=
 =?gb2312?B?VFpsbUkzaTJwYkJOOWdobVpHZVVZS1NNZmJYNnFVdnptcDAwU2pvU2xXM1dq?=
 =?gb2312?B?L1Bwdk9xZkFGS0ExdkI0QnN6dWhpR2U3ZWNzZEt0ajR6T1hVdFV0MWpKTlRu?=
 =?gb2312?B?OTJYZDB6aGRsOHQ0T01yU1h4bHhCQ3Rid21uaCtCL2hlZVFyQkRqVWdBd1F1?=
 =?gb2312?B?bG5JcHlFdldWY1JoRnkzaDY5NE5TUHNldExsRXFaRlpGQ3hWajYxNTFic0NL?=
 =?gb2312?B?ZGxEYjZHcjJKQ2Z5QU5hWG5LajR4THJNNmZoRk5EOVhnZzV4dVJadXIwb09D?=
 =?gb2312?B?WnlKWDdOVmFGbDYwUWZ0M1ViMDRmNjlJT0ExN0tRWkVSc2lJVXFPUWlYdkFF?=
 =?gb2312?Q?cufAurSQ/mr5mprg45ltykno+jyz0JpQS6ErE6lyvE=3D?=
Content-ID: <953943008D9A5E4DB96E244C706794AD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a77bc3-25ab-4de7-51aa-08d9fcf5cd63
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 09:11:29.2192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UciaWVPNTAj4MoIIa2jOgznxntrLIbICVRM0bDEGb/WWK5Ur04b7kUKS3zsA4HDtX6lijPHLK6bfd55kSMEbz5/hJB7wAShaczqG/350AH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4192
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All
> On centos7.9ga, I still hit another crash problem because of use-after-free in
> prb_retire_rx_blk_timer_expired(). Since we free it when timer expired, so this	
Using free is incorrect, should modify as below:
Since we still use the freed resource when timer expired

Best Regards
Yang Xu
> case will crash after we print TPASS info.
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/setsockopt/setsockopt09.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> index 2fc66ebbc..62c6dea07 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> @@ -19,6 +19,17 @@
>    *
>    *  net/packet: rx_owner_map depends on pg_vec
>    *
> + * It also triggers another use-after-free problem in
> + * prb_retire_rx_blk_timer_expired.
> + *
> + * Kernel crash fixed in:
> + *
> + * commit c800aaf8d869f2b9b47b10c5c312fe19f0a94042
> + * Author: WANG Cong<xiyou.wangcong@gmail.com>
> + * Date:   Mon Jul 24 10:07:32 2017 -0700
> + *
> + * packet: fix use-after-free in prb_retire_rx_blk_timer_expired()
> + *
>    */
> 
>   #define _GNU_SOURCE
> @@ -110,6 +121,7 @@ static struct tst_test test = {
>   		NULL,
>   	},
>   	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "c800aaf8d869"},
>   		{"linux-git", "ec6af094ea28"},
>   		{"CVE", "2021-22600"},
>   		{}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
