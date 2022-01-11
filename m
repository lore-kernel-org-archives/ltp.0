Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A7FC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 01:09:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 083243C93EC
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 02:09:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CA773C2997
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 02:09:47 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B2C9B1A0089A
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 02:09:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641863386; x=1673399386;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kX2ga6CjHQAan3VOvt+zhNEq4WqU0E4lq9lHuC1A4dA=;
 b=eTeJb9dxRl0dd1rrTd5UhVHOb6/7mZtABKdigr3SH05Abj6z7aX+rn7K
 3Yw3dVIv9BJvZ28rXCNHFeGfcccPVwtg/6bmk2AneI3WWar/LdlTGm+dk
 LPpv62d0T31Ou0mVUkVrhPpo5pW899f9Dq9rdZsqt7zHopEz+ibk7spp/
 32czMMg/7DqwbZXgPTW1/ogCyJ3ckxQQ5CTjDcdfE0AG5zs3dFIIPqJdf
 /njQcy3AKSDZkBf9aP5ygVqB4NaruBoyc6zEhkQ3RU6r8EEMBvR5nlzfg
 /KnFA4l1Z4xVXmubkAeKETWHEInQp0P7AuvwTNsMGOMH4b4TjtYMk+atu w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47132707"
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; d="scan'208";a="47132707"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2022 10:09:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThgbKObug+9TDe797cf0DOKTOigV+yI4+BWVipjOiyTax9/RCwb8PodhIVyJuO9/FmgwY80Glq2+rBdFTKD3AHspgHDRseCE9RdFic0S8G/Z3jx4A1FXusBSIB8thNo8lSYNoDca6hH0m1Brb2YPH2hY96BYnH9l/81tEyJRFHi13xbl92Pm0fO4gh/BZRIcb8AaYQhL04zAL4rWKHAu3im19RPRTknp3falvLaJD7u0b4O69te3wfPysY30X0WirKS1iA1PogMDi46ptAT10NIDXFFMl0RwdpI/Xvo5W7dbnhDiFbb4X/Lq2VFSbG47awrgHkPxuRjledqUdCa8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX2ga6CjHQAan3VOvt+zhNEq4WqU0E4lq9lHuC1A4dA=;
 b=ET732nf+fQutekldYTgI0KhaAXjRSZSW0Xf4KJuQsrfAD/4IuM7L8XIsBRCSGKJERPxRWaWTm9mD+Mx0apgbZuB/evN0BYmjpH2oIhYTzqpl/ruvXtWo9FXwQRMNlZ1Y/IASqJPK9Bk0v1U92L6tRZc7r7ToGaEC33SMplKdFmqsCpN7rLqNQp0VnrGhoFKlF9rI3rnt5KgiA0VzvtC7YYwp9rclBM+fpr4ZaV28boi7CudWLpa7q/9Aog8uWa5FYNiLQ1ascMBLhNsaNaa4qUuVqABIMs170ME9B25705CRsnNhWrk37sShT3YBlGX0GKoy9JYZWVYQHl9VT6OImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX2ga6CjHQAan3VOvt+zhNEq4WqU0E4lq9lHuC1A4dA=;
 b=RewG13BhdRROZNZMviCrDiduxKgUl2KFpUEShk/syCK3LEdSDcPDxNitsoqDOsoeGIos9L9JeVeaMEIzgdlQebLFKfMO1gSTjO1R8X7D/3U4Uj6cPQ1cvCgVGlbnv0sq9R06yJ3JGycFk8rql4qQcW5x3uaIYoIxdI5PlKy/f5M=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2826.jpnprd01.prod.outlook.com (2603:1096:404:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 01:09:39 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:09:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [COMMITTED] [PATCH] quotaclt: Fix build faliures in
 metadata parser
Thread-Index: AQHYBiIJbr5z6PDwzkGd6lER84fGyKxdA8eA
Date: Tue, 11 Jan 2022 01:09:39 +0000
Message-ID: <61DCD905.2010402@fujitsu.com>
References: <20220110130138.25855-1-chrubis@suse.cz>
In-Reply-To: <20220110130138.25855-1-chrubis@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2d1385c-23dd-4e04-df2d-08d9d49f0ade
x-ms-traffictypediagnostic: TY2PR01MB2826:EE_
x-microsoft-antispam-prvs: <TY2PR01MB282607A41EC2359917C396C6FD519@TY2PR01MB2826.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAVYjd/H985vqSG90dqLwcf0PprxbQMhY+TymDLySnOElB4uXnHrMMDKINx9Vc7RwNayemzR16QFHK/+pAfIwAGGXghFagGSIoHoKyRUzwvZ7SRtdtobJm26MjrpyzYH2ojYYtSCx1dHuBwGXtGaVR+CKo2UwbcSbgDJrLT7vEeSU6fopyfcgOwi0/Xo8E39roySkqtSE2pXmEl8Z1q9pJdGXGjr9Dh9KXl3RBFXzhpjrrli86TB6iC+16kSYWSuBjj5FhFUfUG4GirjaRrXoCFoMTBz2FyohWtYeVehQQhcLkRbHcASEXCXr7RPcKKs/9ytxqLB92z4PJE/HNyTSuftQUbY+Lk/3nEAknLQFt3aQ/op9x/g3eUWq+tkEdxdgZfoOEElq8svV8gajuvP+uaUQhsrh90aMdmQjC3Cmo+9VzTGJzOKvqsLwY5KVaICfFe9HkKuU68PBApnhnLCHYOzu35Qst9KCNnlr0F+Z+GXqWf6nzxZcirzUThA0v+t3rYV+mi3Q6HdxvHK9aDKHOwXv3WL6HsmPmNbWk+81irHZK8qy+dVeYAvHlXRCTg64uQ5UzaFgghJEX7kumlAkunWjXzA96sk3Evy/PxWn7kE3mFxACpjU4jH9hdiU1RKJ3q3MpF4DJJFcY44Ly85xH41PnpeJsD719Yv1/T6HAk8WxroLx8B42qpdABegKoKuwffe1rK5veJjz7FcuB8fQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(87266011)(5660300002)(33656002)(26005)(83380400001)(186003)(82960400001)(66476007)(8936002)(6486002)(508600001)(66446008)(36756003)(66556008)(76116006)(66946007)(38100700002)(91956017)(122000001)(15650500001)(85182001)(71200400001)(4326008)(6506007)(38070700005)(64756008)(8676002)(2616005)(6512007)(6916009)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cUlIOE0xdUd4d2tOdDBUZTNUMmhtM1NzR0E4SE1Jb0VIV3BOUzdNRGE2eHpB?=
 =?gb2312?B?SWprdkptaWRwSURaSGRIT3dNYjU3MkNKZ01OMTFDK3FNVk9OV3ZEWkR5Ujdh?=
 =?gb2312?B?c2k4bjRoQ2tzL0k4aS82L2h3WlZjZ0FGRm9xVlhtbVZNc01uOHFFdGhhdTNz?=
 =?gb2312?B?eDhjWkN1SkZnbHR3dmY4V0xWQnhUbnN3SXJQYXFwYTlEZmpzaE9ycCtpZEg2?=
 =?gb2312?B?dTJDdXYxRVJlN3lCVFl2QlM1Zk5tcFVJaW9HekZ2UEkyQ2l1aE14dUpYK2Rq?=
 =?gb2312?B?N3VjQTRSWS9VT0t0SGpiS0Q1aWZHK2Z4a2k5UHJSSkt6RVB0OWJmOXcwTG9S?=
 =?gb2312?B?ZmRyNWRzakhkYkNvN2c5R1owNzJIWFlpVnErSkxqTFZ4WmpBaVp2SEo2YmdW?=
 =?gb2312?B?QXVQSkkrU0p5MW9ydFhZRndBVmNoNDlUcHQvNWRaRFo5ejNLR1VsdXFSWk9w?=
 =?gb2312?B?emtYRGQ0aFJhVVZ6amNsWUdMMXZJWjhFZzA5ck42aFRrazQ2ZFdVQ05wSjNp?=
 =?gb2312?B?OWtIQlV5c2xDMmpSamtaSWY1aXZBczhaLzBlaGpzRlBYMkhCUXVvdDcrMFYw?=
 =?gb2312?B?M3lOMS9HdG1qU0tEUzZHQStSRElHY2RQTy9JeE52QVpKT0RYMzVpUUFqMURl?=
 =?gb2312?B?aG9NWDYwZHJFOEcraXNad05FUm5YcjJCQ2x6MjcvbWVMbmZ0dGxyZzJJL2ZY?=
 =?gb2312?B?Z3N0ZE41VHBMMkdMSUJnRFpwVlZTdGQxR3gyZzREMGdIai9CaHpqR3VsVy9N?=
 =?gb2312?B?QnVFNWxFRmg5VmNrNEpUSUlGR0swZjBPZEM4SjJBQkN4c3ZseVY0RElmQTE2?=
 =?gb2312?B?ZzR3NWNJbDYvKzltSjZRemtrazBNYUI5OEtkM2NoUldFcG9oWUlTcTQ4YjlS?=
 =?gb2312?B?ZUVvKzBjcjdna3A5UHNUTFJTVXA3eDJsM05WUXJTZ0REVTB2bVVsUElvQ2hB?=
 =?gb2312?B?VGNuN0thVUFFSUpQQjllckVsMGF5NnVFY1lRSmhHMFlSUWczbnNEbEgzRzJI?=
 =?gb2312?B?SzB2MUlidHpyZ1RXV09ETGw2TGUxcnU2UHhsZDBnallwTmpDT3hNd3hIOEZM?=
 =?gb2312?B?L2pLejhNT2hDMXVCbGtrOHltNFhzUE5pNXQyMDk0WEdMNi8yMm1ZcFJiRzEz?=
 =?gb2312?B?RFlQaDhYT1I5MHVKckI0UlRmQitKRkVyNENYZHJTYndRMjJ6R0dWdDJFdGhi?=
 =?gb2312?B?UFRRMWVjZzE5L1dGUy90eDY0bUtqcjgxZ29rOGhPdU5HOGFVenk0eHYzNzlO?=
 =?gb2312?B?VGY1SXlzdkNVT0dDc0IxcjJpUmp4QTdkeWJHeUxXK05mQjNSZW41WjN3RUg5?=
 =?gb2312?B?TjU5WUVNT0VvVUlBL2VEMmt3dmlVb2RMWnpHMmdYRmtaSzlyL2J5Lytha3dy?=
 =?gb2312?B?SGhNTTBSMklIRnVsOWZpTm55Z2RMNDE5MklTOFZpYlhFMkFOUWFCOEhadER3?=
 =?gb2312?B?T2ozaWh6bEVwSXRjdUZ4ZlFUcThnRnBWZVBBTXlKR0grc3ByYlB6ekxFOTlh?=
 =?gb2312?B?clRuK016b2JKaEVMSkc5UnFCWFN1amlOR3UzM1lPUjRHWHpEdVNwT1dXWmNE?=
 =?gb2312?B?QzdoR1JZdjNOcnN1VGRxUTAxK0gwc204aE50eUlPL3RWUHFxNlcxOVIzNHVw?=
 =?gb2312?B?OE1KSDlVMnNEMTdEM3FWcUhPMVBVMVo3Z3Y5WU11R3RmbnJHR0h0RXZFamRi?=
 =?gb2312?B?bUlhOWhCMFBBWGxqeHNuTmwxSWhYVkJVcUQ5R1A1WFdvemlqanB1N2p3dExI?=
 =?gb2312?B?ZCtRUUkvTndRVGp4Y0RidWpkMGVlZTlYVUUwWkdGZnZpNWUyTVBBVlBPN3hT?=
 =?gb2312?B?SWgvQWcxbWNpT0tZNDY5KzNYVXNLMGxHWk1RS2xacWErckVFL2d0WWNjOUYr?=
 =?gb2312?B?QThld2VKYmgyZ280aEpzT1NtWFEyNTlTMTdLdkZHbUpLeFVUc3k4d3k3RUQw?=
 =?gb2312?B?aUUvMlRQekM3YnhlREJKUURpWFVPcHRwSXJSeFZtN0p3MU5NbE5VVGVqL2VV?=
 =?gb2312?B?QjBsZ0lLaGlNRXZkSy9yeVdOS1YyQVhOb0pTNm84WGNJWjd3UjdmdU9ranQ3?=
 =?gb2312?B?K21RRVhlbE0vTGhvRWRPWnV0dlJ5alUzL0w5bCt3TkVTdVQ5QkR0dUV2ZkM2?=
 =?gb2312?B?SklXei9ya2ZuRWsreVdkVlBLT0s1M3ZyMWorRlFtTVZVUjZERTJ0QlVtWU9D?=
 =?gb2312?B?S0xpb0U1d0w4ZnRYT1pMNUFRKzIwbWF1TkVXeTdLbHpScTVzSDE0cGJqTHg2?=
 =?gb2312?Q?rqum97oqUmdKOxiA6WSGfWyn5MMfEZ0SoObk4XhA3s=3D?=
Content-ID: <4C7871E6957BDE47A49606E7148889BB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d1385c-23dd-4e04-df2d-08d9d49f0ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 01:09:39.6121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmkG6Ikd1l3vnZ35CR85iELMDW2FYqfaaTDqVZmRVmV2Zly5M9V6YVXmWWzuv+NXOEXPb3+ZbEQx5NsbuXTn92vjBetmAEt74xFOEonRNfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2826
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] [PATCH] quotaclt: Fix build faliures in
 metadata parser
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

Hi Cyril
> The current parser has many limitations, one of them is that it only
> parses headers directly included by the test hence the quotactl tests
> have to directly include the header that defines the number of variants.

Thanks for your fix. Now, I know this limit.

Best Regards
Yang Xu
>
> Signed-off-by: Cyril Hrubis<chrubis@suse.cz>
> ---
>   testcases/kernel/syscalls/quotactl/quotactl02.c | 1 +
>   testcases/kernel/syscalls/quotactl/quotactl05.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
> index 56fa23b9d..c16e0a3f8 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl02.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
> @@ -26,6 +26,7 @@
>    */
>
>   #include "quotactl02.h"
> +#include "quotactl_syscall_var.h"
>
>   #ifdef HAVE_XFS_XQM_H
>   static uint32_t qflagu = XFS_QUOTA_UDQ_ENFD;
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
> index e56e191df..541007e97 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl05.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
> @@ -19,6 +19,7 @@
>    */
>
>   #include "quotactl02.h"
> +#include "quotactl_syscall_var.h"
>   #if defined(HAVE_XFS_XQM_H)
>
>   static uint32_t qflagp = XFS_QUOTA_PDQ_ENFD;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
