Return-Path: <SRS0=8P1C=PD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81CC433FE
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 07:37:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251FC60FE3
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 07:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 251FC60FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 018B13C1B6E
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 09:37:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 135BA3C14A1
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 09:37:02 +0200 (CEST)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C39491000438
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 09:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1634283421; x=1665819421;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4igXc6WdGcfZEZP5RJf9VsgxSG5YMzatDK+Yn/cutss=;
 b=mUzPXRfvWlQei2QhYFDSoVBQ9m1RSZ/k/rqceoCLO0GxUVraRUtr99af
 OQryeEKbHW4+jWAsDaHCkRmPLiKffTHC1D/8xFHims8rSi7UQQjgQb+e5
 pnJcyKup4uUmnEVNClCXcd6LvVSFA7XVs1s7O39QXPSn2FtovedtM4CY4
 MV/PL1CBDIchl021jOkdrA/7fIxnaafFziGEU3iz3t2cyCLoLhbuYKxX+
 aPTVfkcJJKZRv3Wux9OA9NUpEDU3mpHuc+TCscPSfpHDA2pnksCHweF8p
 vIJT3gr7CoKcXve7El23Vg+T1vgPj6FjzH2O3eBBW6yBSAIoHYPRPZVmS Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="42255002"
X-IronPort-AV: E=Sophos;i="5.85,375,1624287600"; d="scan'208";a="42255002"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 16:36:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWNkPBileGMJaddtqANvEFDcGvCmdSaDnb3vQ9IMUnGmNvLpD8H2t5bEaKSvV9NxB+Y2B3jIew07j9oW39KYHt0CLaedVnF4JlyLMJ1oUcP8K0uRBxgKxeRqQYmZRyiLzA6girYs9YQ/K4lfwjQy+0rJae8BOsI4nrZiTQvdAyobW2M+D5B+coGEeEaIrGDYiQKUrPQbxM/V0zevbfMdTV38ajhKFoR3rpTBN8G9ST7nv5kfkNQMMcZDcltJxCnJROp6dYzbQ6C0MhNtPsatHbU0H9YseG35IDzTfH4ii+mfh/vVWN8285zsMN02uja1dcpd2yMf2Vv5tFWJwO7rXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4igXc6WdGcfZEZP5RJf9VsgxSG5YMzatDK+Yn/cutss=;
 b=CTkHOEHRWDLR10ECl/JwPMppClRBVUp+2ej+D7CAWYW/9JjUqNwD3ED2it+oTABBuAa6RyrrgRq5Lg64YDyuXdwIZoJZsXQz/L+/mNqrTlhHwY1+7Ic6qSJ9Ot9RdfffxeU1zLd99jTcit7kSFIHR8o+H8YFYSinmbMt/vBMoVfTsr2LKMzCU7izyhCrw+EImmtauDfspPr8DgUmxf/QsirC4XjaqTgIx3TnNAUAVty7flIqGokvnzNgK5NtUN6fy4Fd3FXaYjxxvG4mwT4pf6nxlNYEDBneL8xSOtGAuy1s5ib+zfdOy3BsNMhuXndyVFCCwx0ExqmB8tYMobU2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4igXc6WdGcfZEZP5RJf9VsgxSG5YMzatDK+Yn/cutss=;
 b=Cwnoxoo7uekCKpSjlSvw62U9NWmIKbUL7r2M4gIEjNljr5DNmbVfPqHfmXzIzasPq3Od3gUkkRzzw+MinXGgO4HKRVkLVUoscubEFFgPl+wx3+yuj49qmkM1mNb/qQGhDlsyCrnl5uLBJQWfUwZorXHjlirqCyLRRAG1TyZAZc0=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4203.jpnprd01.prod.outlook.com (2603:1096:404:db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 15 Oct
 2021 07:36:53 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 07:36:53 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/1] creat09: Run on all_filesystems
Thread-Index: AQHXwZaXPPMtTgORakq6PBXdd9maU6vTq64A
Date: Fri, 15 Oct 2021 07:36:53 +0000
Message-ID: <61692F98.80404@fujitsu.com>
References: <20211015073031.18642-1-pvorel@suse.cz>
In-Reply-To: <20211015073031.18642-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb9946fa-7db0-4fb6-8256-08d98fae8f05
x-ms-traffictypediagnostic: TY2PR01MB4203:
x-microsoft-antispam-prvs: <TY2PR01MB4203B6E795DDA4F358A2F0CFFDB99@TY2PR01MB4203.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:154;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLnQLAgmR0Ngf76mjkwmWMQUPvMQk2J+fIn5hF06lhX+kyiGItHoNxZXNdEcQpnHzHAXprS23AE8CmUdAlyEFexkwHmdQ74dt/4pDQE92Ik4xNh+r++BLbMFG6ccaIku/hEeoGGaKFElUy72Cl9pItKI+3tT8dQbclhxG5cXeALwemXyhwreKEuNEg7+RiUk/csOqelMOP2VCrfQZQelaGYi4iPE4Ec2MfhbjMo0PY4xmFuHWcaCCJWffpNcPnc5IOusQoZirfjCwSryWwTQEG2CfPHu4wKUTH8J5tRkAluLrSpo/canDVz2D0kKqiIaYM4YWoeh9kD5OaWvUQMUGOW8gSVQOC0J6+Z/SWxx1Xt0qyofo+6Xs9QcHjDThSuBRnWDA7j9FATgF6rFEl38tMBfrPB/0WrOXpsOO7N9DEhQCSSroqlSc4pVobSf5L1NdB2qNIRsXdqaz3HGDmiTiwBIFyeJOOqaOB8ttBgpI1tIUULrTnyEFjzSoQpvlHwmT0bK5SABb3bkmT45jVwsMFIrANOGpcmKCqrmBULbD9UDBkMmP079bBfue+vtk4jD/xDFDPrE6RwuN7fqoCy1p6hEigY2UZzX1XoEeSzZ9h58fk3xhqA6Fvo7qV4AeDgTeMGDi/ZE5/rkiVwNPhf2HIA/Qtb7oeetJRhHD5NzUAJ82BhsvczLrEq9/KPdkcQXZOx41G5/7Xr3BPMwWh8nng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(6486002)(8676002)(6506007)(85182001)(2906002)(33656002)(316002)(5660300002)(66476007)(186003)(45080400002)(6916009)(508600001)(6512007)(86362001)(4326008)(66556008)(64756008)(71200400001)(8936002)(122000001)(36756003)(66446008)(66946007)(2616005)(91956017)(26005)(76116006)(83380400001)(38100700002)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cnFpZUFVRGJDY0NYdzN4eGNHOUZ2SzBLU0NCbHZkVHFISzRtandWZXJLVlB3?=
 =?gb2312?B?UnhqNU94c041UG80a2JpeW9TUUhVR3VydUhvK2pRZDZQdG9nYzBzZ0V0UDJE?=
 =?gb2312?B?YUUwdDZvSzB3NGlmK1pkajZnU3ozVG9JMnI3dGxjc0FjR1VRU1plUzVHTnZp?=
 =?gb2312?B?cXJmOGgrTngxU05Kb1FjMG5XTWxEZGRZVm5GV2laek4wZ2QwQ2I0Z200YjRE?=
 =?gb2312?B?MHVzVVVFZ291TjRvOVFDSWVpTUlMR2tLNG56MXZFSXZyU2tmSUNZZ0ZNVEg0?=
 =?gb2312?B?aURZMXRFcGJKdE11RnZ3SDhldWNaS2JBcVdlQ29IT2JmaWg0ZEN1eis4cGov?=
 =?gb2312?B?U3U5akNuWE9xSHVHakJXOGJlallTRTBZaVhkVFJZRVlGVmRlcm1GQ3h2QXFR?=
 =?gb2312?B?RHhPUFRVZHYyelI5bTFTNno1WUsvMXFXNmM5T2c1MzdyRXhlcUY4YWpORXNo?=
 =?gb2312?B?QWh0RUFLVHU2RkloSWdCUXRCeGZBc1EzeGdqbk5IZHE5WEhTNUxEV1VCdHBJ?=
 =?gb2312?B?YnRnQWN2b1Z1bTlnN1JrSTljTitKZEtxVS9jZFkrNEltdlhUNXhuMVRxbi9i?=
 =?gb2312?B?UkRVUGFoWC9lVkNSUHBCejBEa0V6UHQyL3VvZVpEczZwNEt2ZkJVUG1oMTBT?=
 =?gb2312?B?UGZwVHh5b0dpaUQ2Y3I0ZzBQSzFSdSsrMzBRRXpnSDVLaXFFTzVpOGVrMWRG?=
 =?gb2312?B?MWU2Y1cwcmdXNGExeFIxUUpYVWUzalpIQmpxUi9oeGJjZC8vTWI1QXp5MWJD?=
 =?gb2312?B?TlhSQVlwUzlwM0NuLzBnMjUvWlFjaW1xT0NhZDJpQjVKUUxPN09Lekl4a1B2?=
 =?gb2312?B?MUgrTnp5anZoMnNYYWhpb1JkazJtL3B1amlWdzZQeVFGUi9KZEpNcUgwb2NK?=
 =?gb2312?B?c0dUTzlTbC81RGx5QUxtQUs0amRsYzNyaUN0cFFkU1A0dk0ycXhCOTB2RlhH?=
 =?gb2312?B?d1FxVm0rMWhoQzBzS2Q5UnoxTFUrNHZXZkp2M20vTTlpRXhhd2RJbUdQZitE?=
 =?gb2312?B?QTJkd2hMTGFXTFVpU2Vrd0Uvbk1VWWZvRGlJWGpjazZ4Z1J5SUFXdVkzNzNS?=
 =?gb2312?B?eDExSlNpZWp0VUZpTERpUlowS3FXNm10VDRCcVFKajBVL1RRV2RzdWphSDR3?=
 =?gb2312?B?VFBNVlpBUDJqR2VReEJrdXdSM0RhVXdEN3FIWUVvT0hDenVwMWNaZ1hpZExu?=
 =?gb2312?B?YndmcnFWUTdScGFtVndlQ0x3SFRBOCtlN2JNZjJyZnd4d0R2ZStZNFVTN1lJ?=
 =?gb2312?B?cHQ3K0xUSDlvME9MOGZsY1JGY1RCZGdhbHR1cTQ3WDhZbkJHUDhLQllXN2g0?=
 =?gb2312?B?ZmJSclFYeDd6ZGRVajY2Zi92b3dtZnRWcmlzTVVlMElwdGZ0WlFkOGlaQW9q?=
 =?gb2312?B?L3hMU1BPUTkrbGVTdzUxY2xmT2JiaFp4MGpvUnlzUmdjYWVab1R5RG5yUjhx?=
 =?gb2312?B?SU5MTmN0dFFHN2psQThpNFVJOUNkMjBLa0czY2Y2TkF0U1l3RGVuREU1czJo?=
 =?gb2312?B?T1BqczF0T2NpODVWNnkzVmx1TTBSYjZONlJ6STViYW1yQWlSakU5b0lsQVlw?=
 =?gb2312?B?TUJza0h0Z00xdm9TRjA3UnpGNngzdW5SUjcvMzAzR2ZxU1ByMjlLYjhnMHl5?=
 =?gb2312?B?eTRscnp2UTJoRWZYMFY0VXd6TDRqY2dHU0hhMkVTLzI5RmY4S0x3eTlleXJn?=
 =?gb2312?B?cHpCK1hTMHVHdDZwZnpXc3MxUnEyRUJ3OTE3TVNzeUVQcXBRRmtBZC9mdzgr?=
 =?gb2312?B?UVhkaGxBZW5QcERhQlV1SXozbUtyS0FDVlNkRkpSTXBkZlFCZlBTTDF6aUd2?=
 =?gb2312?B?SEpWTTNPUDRuTm9MY01Cdz09?=
x-ms-exchange-transport-forked: True
Content-ID: <058B339895BE954491670505F7B14AB6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9946fa-7db0-4fb6-8256-08d98fae8f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 07:36:53.4995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkyuqxaVfSFv8gv+X+SFfZ1zOlldv5KRXcyrYMILoVMcuo5xFHVQ4VOw7HIe2PHyYKvKg76d3osbJYJ5vkCCnjBdregVE1qh+mO7vfYTqN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4203
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] creat09: Run on all_filesystems
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

Hi Petr
> To make sure bug on XFS is detected on systems which use it.
>
> Due setgid is test problematic on Microsoft filesystems:
>
> creat09.c:81: TBROK: ntfs: Setgid bit not set
> creat09.c:76: TBROK: chown(exfat,65533,4) failed: EPERM (1)
> creat09.c:76: TBROK: chown(vfat,65533,4) failed: EPERM (1)
>
> thus they're disabled.
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
> Changes v1->v2:
> * drop useless code creating directory (reported by Martin Doucha)
>
>   testcases/kernel/syscalls/creat/creat09.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index 681b80c7d..1d6c1643c 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -33,13 +33,15 @@
>   #include<stdlib.h>
>   #include<sys/types.h>
>   #include<pwd.h>
> +#include<stdio.h>
>   #include "tst_test.h"
>   #include "tst_uid.h"
>
>   #define MODE_RWX        0777
>   #define MODE_SGID       (S_ISGID|0777)
>
> -#define WORKDIR		"testdir"
> +#define MNTPOINT	"mntpoint"
> +#define WORKDIR		MNTPOINT "testdir"
You missed "/".
>   #define CREAT_FILE	WORKDIR "/creat.tmp"
>   #define OPEN_FILE	WORKDIR "/open.tmp"
>
> @@ -51,6 +53,8 @@ static void setup(void)
>   	struct stat buf;
>   	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
>
> +	SAFE_CHDIR(MNTPOINT);
Why need chdir?
> +
>   	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
>   		(int)ltpuser->pw_gid);
>   	free_gid = tst_get_free_gid(ltpuser->pw_gid);
> @@ -119,6 +123,15 @@ static struct tst_test test = {
>   	.cleanup = cleanup,
>   	.needs_root = 1,
>   	.needs_tmpdir = 1,
This can be removed.

Best Regards
Yang Xu
> +	.all_filesystems = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.skip_filesystems = (const char*[]) {
> +		"exfat",
> +		"ntfs",
> +		"vfat",
> +		NULL
> +	},
>   	.tags = (const struct tst_tag[]) {
>   		{"linux-git", "0fa3ecd87848"},
>   		{"CVE", "2018-13405"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
