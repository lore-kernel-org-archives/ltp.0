Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C78C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 01:38:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33AFA3CA370
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 02:38:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B6FD3C9894
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 02:38:12 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 90499200C82
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 02:38:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646357891; x=1677893891;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9hP/D+9kjO1Py3WxKH+WjEDCXj1iNsiuGyTB/ZEojNw=;
 b=stPdWD7Fic6x7t+4Tnb1MYGFYFMFq9cna+Yv2qmION16I13E/08Qh9nQ
 mCPL6OyWpaErbesBYSb0/oBbTdyJ3LubfBQjvu5OnREsKDpP+SU2rwaNF
 hhQEHJJdYQ/5WcOw1QtGJRkGwx/jKvX6vavJC09w5FbEP0nvspfNeFiYe
 gObWj2QiEi8gE2AsQocVh0EPBI0l7veXh4mCJVUBDJMNPQmn17f/jlXc1
 cl+be8UsNGSnEQg+OxUg7QIYIC7NJURUl4exux1D/MSwrjHEae9utrZup
 9iEQKPridKaVOjSbVvTVENIGGPPZLMKwzbuvnSLO0Ghm1EautD81FkezC w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="50958007"
X-IronPort-AV: E=Sophos;i="5.90,153,1643641200"; d="scan'208";a="50958007"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 10:38:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6JgllplcdZJyCzYvhgVQVjlMRGR3k8jCHSPb6JNomG2NFgEhArbYjoULpG3I24uR7Y66ouzUWOeAeYvEuzPmcCP2noKJbcXUEdV9HxeX6ED5uKQIhM3QX4EKd69zxWbeN+fjlcJJcXMIlSfH1m3tHyNI0UWvdNdd1/Ar0xfLJ7UFhPg0jEe3nsGvkg6YFujUbXijqpcIi5MIAbGI4btUOALqXnsTNJhxlkSPjoyAiuOBUve5gjiGw3QjzmhS1W7wLyCW3svucOe7Bo/odDt0SPYC9BEGsAB+yrrJd7GuB5dPWTv38wA2gBbO1qMZrQv3f9WLZWUdfJMCvM82mMDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hP/D+9kjO1Py3WxKH+WjEDCXj1iNsiuGyTB/ZEojNw=;
 b=ETYdAlUZh0latEy/K9C/aqc6GCvZdskiAkfE/q01vH/Vkh3cJX1iZ8FBkYCgck6KGKPpdfHdhmwP150uDIDV4r0vcb7JrSifdXncojDmjByeLPmuo353RMz6obkKKsfW73F5NU5tPqqN4M852+J2VxA8LG0ukJbddwjospi50+00E2WfmMdF7dxzkjBgPhtHzRI5b2vHk71DLkXcuOmqp6AxFOxTEJJQs8I8kAevjYTUxo+7tTBef2uqK15fNxXnK9CFhMhqbBodkyNURlpw+qCY5wr23olokSeqASV6EwfuVLG8NPuWL7uv/I4BSSBT8ZcVBjMlEFSRqoGDfX0Blw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hP/D+9kjO1Py3WxKH+WjEDCXj1iNsiuGyTB/ZEojNw=;
 b=Ze96BU2JW2NAQ0QIAMzaM3hq4jSqh44nHEqgNioqQs92x3dRwJPje51eCheTdMC9cGP3q+raiAaChXTzyZB8Sx+gNP4MiJ0qWszn4bzoPNV0tziUVJKRxEYKg6G/RFJxSg0zLxu7HF7YHcS7X9SO4nnB+AdLqY8GEPmxysK2cXY=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB5292.jpnprd01.prod.outlook.com (2603:1096:404:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 4 Mar
 2022 01:38:06 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 01:38:06 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [PATCH 3/3] quotactl06: Fix TESTDIR1 cleanup if setup() exits
 early
Thread-Index: AQHYLxPGiBnZiWFgCk2Lm2SCIUr1tqyucxkA
Date: Fri, 4 Mar 2022 01:38:06 +0000
Message-ID: <62216DB6.8040202@fujitsu.com>
References: <20220303153131.3372-1-mdoucha@suse.cz>
 <20220303153131.3372-3-mdoucha@suse.cz>
In-Reply-To: <20220303153131.3372-3-mdoucha@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b121c084-9faa-47dc-a682-08d9fd7fa1da
x-ms-traffictypediagnostic: TY2PR01MB5292:EE_
x-microsoft-antispam-prvs: <TY2PR01MB5292FE1D7D306EF20F397EC0FD059@TY2PR01MB5292.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 29d09ipweA5BMu8Rz1nI3A3B5QjZyfQeajTIupVD7NT96z8Z1n+rdYEkvbriyQeuIiWVORB7VLOIFRBIdgNdd7iPLJsbPOLMgyvkHh73fRpphdch+W8yfHVQWwpZjmEA96cz1D8H621w4Hz2oHXYRlI8dJ0yl9qbbzELmVSKr1m9ydfgLmyMqKNCm+QcJK4FDDRKJTShMPWyugfOA27w/0/sAN6yIkumlRGwUz61ZYSrDuqJfbgHpBsAoAAY0EVVnKdb8YH5CSDmjo1CsQqqMXpGXp4QpsyiyU2YpdgpEj22fEmxamh2uJZeZ23evr2xoPfzHNrfbEZFzhV+vHLAb1HgbB52OHBluClO7DCtMxOA3F9c51Msd66Fj7sTnM80RjRK+vWp2uBVGz08sJIuoLGbcevoAqrr2stsTZDW4XdZ5purxdzDpDYfchYn2uJ0Gu/F5pEoN8/vcPXgttlCjS/hFQakOrDWMC5C9lELXdoam4XdO6wSwvyTMXnoJWSEwgQNX+VCVCDfqufdCZ72CxePbW6KNaXmKyYowAQs68fjP7VTy81sGCj8yXJ4CmACYAaPrm2iwdGJp2H/N/ZOExkWkA1MAEktoBFd3IwJPYw5nnAfOC3CJ1K/GvT7MQ7UoZ0+OZyN7uLNGYcYOg4jJYeI5w7s9LyPeL9CmPO3yJjEa3ZLo9eab6RQWCjALEp1MkZ3FcynrJHdigz0Pa4sbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4744005)(6486002)(2906002)(36756003)(5660300002)(83380400001)(122000001)(71200400001)(508600001)(8936002)(15650500001)(82960400001)(85182001)(6916009)(33656002)(6506007)(76116006)(2616005)(6512007)(316002)(66946007)(91956017)(38100700002)(4326008)(8676002)(66446008)(66556008)(64756008)(66476007)(86362001)(26005)(87266011)(186003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bVQzYmFTUDExTGgrTUg3RTJ0eHZKR0xPa2xmbWpTcXdTaVNTVjlKSTdWVEY3?=
 =?gb2312?B?dHpYUFNPRUZ1ODY5ODluOUVjcWxsNDhVaFNuMXVYSXFpdTRQQmNqK2orSUpS?=
 =?gb2312?B?SnkzMlJ4alA3ZU5zR0xRbVBxZTQwb2EvUUVvRjZYMzJrVzB5Y1J3ZW1UcmFx?=
 =?gb2312?B?UTVyS3hXT1FhUmR2Q2YzNUZEcGJvLzNMdkk2QjA3a0wyWW5STDExZFVpSkRQ?=
 =?gb2312?B?ckVrc3pFRWhscHVBS0J4MUJLbnQySDV1MXdvUTlxaG52RDI4WkFHamV0UjNG?=
 =?gb2312?B?dzBKUnJpWHR1WU85cGFkSU1LVnBXbnlTSFE1WFg5YVNLOE05dUFOaUtsWVMr?=
 =?gb2312?B?T2xLWjZlYXFkQ3EyY0MzRi9jYlZZc3pPMlFmbzFrNDdLTCtEL2o1VTk1WEFM?=
 =?gb2312?B?bXZoN2VIb3BXSzJ6OHdmeEVlUzlOTWlSMThZU3A1RWtFU2NyR3JXemRuUkpk?=
 =?gb2312?B?alVWN29EdyszTE5OMjJwTndaTjdBcFhXVkRNV0ltOGl1dlhDcTA5R3Q2R1RC?=
 =?gb2312?B?aDg4YkpKUmRkV1JTbU9lRi90Zi83L2NweDdUQ0FSaUsxSHpsSTJVQ0U5a29q?=
 =?gb2312?B?SStZTnMyeTE3eFh4TmFCSzFuWk9iWTYxU1pHdWY4SWU5NUVESEJ4MjJjaFhl?=
 =?gb2312?B?NllRQURNUFg5Q2w4cDljcEtWeXNodmY2UDRZcHFETTBMaUo3Y0Flc2ZFVnQw?=
 =?gb2312?B?VUNXNllqbC9DbE9xcEc0S0hvYUVnalRPeUhMbXpEanpNdHNBYTUxcEJlOG9P?=
 =?gb2312?B?OUhrTzlNaGF0aW5sTmN0b0p5a2ROUk5JUFZIekV0anNTdFRHZlBYMyt6M2Nk?=
 =?gb2312?B?NWRaWUxmWDJxYTBKZk8xbC8zenhiSkc0SGd5eDVpaGhMQWVSWVdKQmtqOWlv?=
 =?gb2312?B?dS9HNUV1T3I5aEd6VVJ5SDNXRnRUMW5yVnQzeUp6S0lzVHdSKzd5SURDajVi?=
 =?gb2312?B?ZUowbUNpdGxYTnZ0cmhHRUVpWHZZMjZOckhSWDF0YTZlVk1tU3R1S2VpM2VY?=
 =?gb2312?B?YTEvQ3dEakVvZzR0VjNKVkZ4bWIrRkZvN0N2aVdMOFpwZWtiT2JHME5YRjFq?=
 =?gb2312?B?WFhMd2xJTVd5bFJDYXozZW1VNWU2OElGNGxPbzNkRzIrbElnZGYxUlFFcEFo?=
 =?gb2312?B?eWZtclhzZUtKcWR5NmE0MW41VEhxK3VKQlBRS1B2bkRrRHdrYnVoalMvYXN0?=
 =?gb2312?B?SDZjOFhCZ1k0ZTQyWmo3MlphRTRvYmJaUldDbDMydW5NVUFta1h3T0dMblYr?=
 =?gb2312?B?YUtkRmxQU21nZExCckRYNlVqYW1lem04R2w5endHQkJCZlh3WWh2WGtwN1oz?=
 =?gb2312?B?anEvbVgweW94NUY1ZWtSOUIvSXVJYVhvTXVqNFpVZXRjbXVHOHFCZW50V3FY?=
 =?gb2312?B?MnV3T1o1bllsYlozWVM2S0c3RkhpV0VtMzROUW1neGJRa3RTeWdjRmltN2ZX?=
 =?gb2312?B?aHp4SHBxWm5nM1dvbTN2dGxTSnZQaFhUQ3JwN2hIVnhucjdtcEJUL3c2TzNH?=
 =?gb2312?B?cEZJOWJ5S2VCdHZCTWZnNDBuazAydkhxV0FQdCtTR1pmaGRJVHhpdXF4Tkxv?=
 =?gb2312?B?VE9nNnozL0pYZW9KemdGd1VmZUVpbFFTT1l0b1JValI1cXhXanMyOS9Hc1Rh?=
 =?gb2312?B?Q2xhZmE5aFpDN0QvbFYxbk1INU9tVElwOTllMTlmeU41RGt3UDFWWkxJUzRY?=
 =?gb2312?B?YUIraXV1TkFsdFZMWmlDVGszVGtmbzBaeXE3ay9TZjI4Q24wYlVhbzRIeE00?=
 =?gb2312?B?VE4xM2ptQ3F2bnZjZ1RUT3N2d3N2TytJc01CVjJkbHNBZ3AwOHZzZkpndG1K?=
 =?gb2312?B?elVjZGlvd0dRZER2VFpUa2FSaTUxdGluNTVKODR5MXIzaVhYeXcxWXNwMWNJ?=
 =?gb2312?B?encyUlY1UHhFUWZGOTdPRWxzR2RXT3UzVnBqODcwMVlmMDRRK01WTzgxajIv?=
 =?gb2312?B?NEZwMDZkaUxxQU9lTFJySlM4ek1ldUN1NXFpcHc5Y2lNMzRDWDl6Z2pHOHJo?=
 =?gb2312?B?U0o4YWVxU0tSOGwwOVUxYzIzVVlnSnRSRjhiVDNMaElEZVcraXJvM1VxN2tY?=
 =?gb2312?B?ZVFJTGZ6Z0QyOE9PV0pxUWJDT1dvTVFzWllkaEtPR0w1NGdRTWhkSW5YaGR2?=
 =?gb2312?B?VFlSYmxPR0s1WHVHYkhKSW5XR2wrZTlrTDBieTJyaUZCMnNNaDExak5NdXpu?=
 =?gb2312?B?MTBCNVc3RHVBVjNQNnEzV3JpMW82ZEtSTXphMDl5SzB5TUJuc2MvOVdHVk1I?=
 =?gb2312?Q?7sPPIsXv2rQMKt+1f3ryItBC28sIzE1men54CkVmsM=3D?=
Content-ID: <C71FA8658316314CAAE62FA1419DB7F3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b121c084-9faa-47dc-a682-08d9fd7fa1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 01:38:06.7458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhdh2l9Alw+3OZLaArDbctdFlKrkBwGY8M06QlzWQP3YsC/L3HZbKyX7KgH+FsbxJ4l9k90HQCIVylKbZQVCpjAycmKk7IJ2up9uxiUY1Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5292
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] quotactl06: Fix TESTDIR1 cleanup if setup()
 exits early
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
> When setup() exits with TCONF before TESTDIR1 gets created, cleanup() will
> trigger TWARN when it tries to delete it. Check whether the directory exists
> before calling SAFE_RMDIR().
> 
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
>   testcases/kernel/syscalls/quotactl/quotactl06.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index 8e9a17393..d470486d5 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -207,7 +207,9 @@ static void setup(void)
>   static void cleanup(void)
>   {
>   	SAFE_UNLINK(USRPATH);
It seems we also should check USRPATH whether existed.

Best Regards
Yang Xu
> -	SAFE_RMDIR(TESTDIR1);
> +
> +	if (!access(TESTDIR1, F_OK))
> +		SAFE_RMDIR(TESTDIR1);
>   }
> 
>   static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
